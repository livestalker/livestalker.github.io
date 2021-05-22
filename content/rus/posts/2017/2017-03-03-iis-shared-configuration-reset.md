---
title: Как сбросить режим общей конфигурации у IIS сервера
date: 2017-03-03
categories:
- sysadmin
---

У одного из моих клиентов был настроен MS Failover Cluster и на нем "натянут" сайт на IIS сервере.
Вообще, обычно делают балансировку, а не FC, но как говорится, любой каприз за ваши деньги.
Клиент захотел - мы собрали. Давеча обнаружилось, что IIS сервис на обоих нодах просто встал.
Стали разбираться, оказалось, что местные админы поменяли пароль на учетной записи, с помощью,
которой IIS обращался к папке с общей конфигурацией.

При этом, если попытаться зайти в IIS Manager получаем странную ошибку:

> There was an error when trying to connect.  Do you want to retype your credentials and try again?

Получаем проблему курицы и яйца - чтобы загрузить IIS Manager нам нужна конфигурация, а чтобы поменять
конфигурацию нам нужен IIS Manager. Конечно, можно поправить файл C:\Windows\System32\inetsrv\config\redirection.config.
Но, каждый раз при смене пароля это делать не удобно.

Можно воспользоваться следующим скриптом:

```javascript
try {
    var config = WScript.CreateObject( "Microsoft.ApplicationHost.WritableAdminManager");
    config.CommitPath = "MACHINE/REDIRECTION";
    var section = config.GetAdminSection( "configurationRedirection","MACHINE/REDIRECTION" );
    section.Properties.Item( "enabled" ).Value = true;
    section.Properties.Item( "path" ).Value = "\\\\share\\folder";
    section.Properties.Item( "userName" ).Value = "xxxxxxx";
    section.Properties.Item( "password" ).Value = "xxxxxxx";
    config.CommitChanges();
}
catch(e) {
    WScript.Echo(e.number);
    WScript.Echo(e.description);
}
```

Вписываем необходимые параметры, сохраняем его с расширением js и запускаем на каждой ноде из
консоли (с админскими правами). Если нужно просто выключить общую конфигурацию, то можно оставить
один параметр section.Properties.Item( "enabled" ).Value = false.