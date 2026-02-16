# Структура репозитория

## Дерево файлов
```
.
├── index.json
├── manifests
│   ├── lists
│   │   ├── include
│   │   └── exclude
│   ├── ipset
│   │   ├── include
│   │   └── exclude
│   ├── strategies
│   │   ├── nfqws
│   │   ├── nfqws2
│   │   └── byedpi
│   ├── bin
│   └── lua
└── files
    ├── lists
    │   ├── include
    │   └── exclude
    ├── ipset
    │   ├── include
    │   └── exclude
    ├── strategies
    │   ├── nfqws
    │   ├── nfqws2
    │   └── byedpi
    ├── bin
    └── lua
```
| Директория | Описание |
| --- | --- |
| index.json | Файл содержащий ссылки на манифесты всех объектов репозитория |
| manifests | Директория с манифестами
| files | Сами файлы репозитория |

## JSON файлы
**index.json**
```json
{
  "schema": 1,
  "items": [
    {
      "name": "",
      "type": "",
      "manifest": ""
    }
  ]
}
```
| Переменная | Описание |
| --- | --- |
| `items` | Массив объектов репозитория |
| `name` | Название объекта репозитория |
| `type` | Тип объекта репозитория(все доступные типы будут описаны далее) |
| `manifest` | Ссылка на манифест объекта репозитория |

**Доступные типы**
| Тип | Описание |
| --- | --- |
| `nfqws`, `nfqws2`, `byedpi` | Стратегии для nfqws, nfqws2 и byedpi соответственно |
| `bin` | Фейк |
| `lua_lib` | Lua библиотека для nfqws2 |
| `list` и `list_exclude` | Списки с доменами |
| `ipset` и `ipset_exclude` | Ipset'ы |

**manifest.json**
```json
{
  "schema": 1,
  "name": "",
  "version": "",
  "author": "",
  "description": "",
  "dependencies": [],
  "artifact": {
    "url": "",
    "sha256": ""
  }
}
```

| Переменная | Описание |
| --- | --- |
| `name` | Название объекта репозитория |
| `version` | Версия объекта репозитория |
| `author` | Автор объекта в репозитории |
| `description` | Описание объекта репозитория |
| `dependencies` | Список зависимостей объекта репозитория(Содержит ссылки на манифесты других объектов) |
| `url` | Ссылка на загрузку файла |
| `sha256` | Хеш файла(алгоритм sha256) |

# Пример
index.json
```json
{
  "schema": 1,
  "items": [
    {
      "name": "strategy-sample",
      "type": "nfqws",
      "manifest": "https://raw.githubusercontent.com/CherretGit/zaprett-repo/main/manifests/strategies/strategy-sample.json"
    }
  ]
}
```

strategy-sample.json
```json
{
  "schema": 1,
  "name": "strategy-sample",
  "version": "1.0.0",
  "author": "zaprett-devs",
  "description": "Пример стратегии",
  "dependencies": [
    "https://raw.githubusercontent.com/CherretGit/zaprett-repo/refs/heads/main/manifests/list/list-sample.json"
  ],
  "artifact": {
    "url": "https://raw.githubusercontent.com/CherretGit/zaprett-repo/main/strategies/strategy-sample.txt",
    "sha256": "106714aed888f39b5f7b5342447a3aca5d06eaeda7b95d9995f0cffdedf696c3"
  }
}
```
