
# 🌎 Mundo Wap App

Aplicativo desenvolvido em Flutter para execução e gestão de tarefas de promotores, com autenticação, sincronização local via SQLite e formulário dinâmico para execução das tarefas.

---

## 🚀 Funcionalidades

- 🔐 **Autenticação:** Tela de login com validação.
- 📦 **Cache Local:** Armazenamento de tarefas e dados do usuário no SQLite.
- ✅ **Execução de Tarefas:** Formulário dinâmico que se adapta aos campos da tarefa.
- 📝 **Rascunho de Formulário:** Dados preenchidos são salvos automaticamente, mesmo se o app for fechado ou colocado em segundo plano.
- 🔄 **Sincronização:** Status das tarefas atualizado localmente.

---

## 🛠️ Tecnologias e Bibliotecas

- [Flutter](https://flutter.dev/)
- [Dart](https://dart.dev/)
- [Flutter BLoC](https://bloclibrary.dev/#/)
- [GoRouter](https://pub.dev/packages/go_router)
- [SQLite (Sqflite)](https://pub.dev/packages/sqflite)
- [GetIt (Injeção de dependência)](https://pub.dev/packages/get_it)
- [Result Dart](https://pub.dev/packages/result_dart) (tratamento de sucesso/erro)
- [Path Provider](https://pub.dev/packages/path_provider)
- [Logger personalizado](./core/utils/logger.dart)

---

## 📱 Arquitetura

✅ **Clean Architecture + BLoC + Injeção de Dependência**

### Estrutura dos módulos:

```
lib/
├── core/            → Configurações globais, temas, rotas, injeção, logger, etc.
├── data/            → DataSources, Models, Implementações de Repositórios
├── domain/          → Entidades, Repositórios (Abstrações), UseCases
├── presentation/    → Pages, Blocs, Components e Widgets
```

---

## 🔗 Navegação com GoRouter

- LoginPage → Acesso com credenciais.
- TasksPage → Lista de tarefas.
- TaskExecutionPage → Formulário dinâmico para execução da tarefa.


---

## 💾 Banco de Dados Local

- **SQLite via Sqflite.**
- Tabelas:
  - `tasks`
  - `form_drafts`
  
---

## 🚀 Como rodar o projeto

### ✅ Pré-requisitos:
- Flutter >= 3.29.0
- Dart >= 3.7.0

### ✔️ Instale as dependências:

```bash
flutter pub get
```

### ✔️ Execute o projeto:

```bash
flutter run
```

### ✔️ Para gerar APK:

```bash
flutter build apk
```

---


## 👨‍💻 Desenvolvido por

- Arthur Gabriel

---

## 🏗️ Estrutura inspirada em princípios de:

- Clean Architecture
- Domain Driven Design (DDD)
- SOLID
- Bloc Pattern
