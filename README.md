# zaprett-repo

## Зачем нужен данный репозиторий?
* Для хранения списков доменов, которые можно скачивать из [приложения](https://github.com/CherretGit/zaprett-app)
* Для хранения стратегий обхода, которые также можно скачивать из [приложения](https://github.com/CherretGit/zaprett-app)
* Для хранения айписетов, которые можно скачивать из [приложения](https://github.com/CherretGit/zaprett-app)
## Как загрузить свои списки/стратегии/айписеты

> [!IMPORTANT]
> Изучите [документацию по структуре репозитория](docs/structure.md) перед началом


1. Сначала нужно [создать форк](https://github.com/CherretGit/zaprett-repo/fork) данного репозитория.
2. Затем создайте новый branch и внесите изменения — в новый или существующий файл. Согласно [документации](docs/structure.md)
   **ВАЖНО**: в списки нужно вносить **все** домены, а не только домен главной страницы. Например:

   **НЕПРАВИЛЬНО**:
   ```
   youtube.com
   ```

   **ПРАВИЛЬНО**:
   ```
   googlevideo.com  
   youtubei.googleapis.com  
   youtube.com  
   ggpht.com  
   ytimg.com  
   youtu.be  
   yt.be  
   ```

3. После выполнения всех шагов на главной странице репозитория появится плашка <img src="images/3.png">. Нажмите **Contribute** <img src="images/4.png" width="150">, затем — **Open pull request**.

## Готово!
Мы проверим ваш pull request, и если всё в порядке, опубликуем ваши изменения.