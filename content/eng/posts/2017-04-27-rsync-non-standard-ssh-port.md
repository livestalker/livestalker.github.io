---
title: Rsync with a non-standard ssh port
date: 2017-04-27
categories:
- linux
---

It's so simple:

```bash
rsync -avz -e "ssh -p <PORT>" user@remotehost:/src/ /dest/
```