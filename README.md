# 📱 Carrinho Cheio

<p align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.44.0-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-language-0175C2?logo=dart)
![BLoC](https://img.shields.io/badge/State-BLoC-purple)
![Clean Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-brightgreen)
![GetIt](https://img.shields.io/badge/DI-GetIt-orange)
![REST API](https://img.shields.io/badge/API-REST-red)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20Windows-lightgrey)

</p>

Aplicativo mobile desenvolvido em Flutter para criação e gerenciamento de listas de compras. Permite autenticação de usuários, criação de listas, adição e remoção de produtos, marcação de itens comprados e persistência via API REST.

**API utilizada:**
[https://listadella.azurewebsites.net/apiListadella_desafio.yaml/swagger/index.html](https://listadella.azurewebsites.net/apiListadella_desafio.yaml/swagger/index.html)

---

# 📚 Sumário

- [Screenshots](#-screenshots)
- [Arquitetura do projeto](#-arquitetura-do-projeto)
- [Injeção de dependências](#-injeção-de-dependências)
- [Abordagem de Front-end](#-abordagem-de-front-end)
- [API](#-api)
- [Como executar o projeto](#-como-executar-o-projeto)
- [Melhorias possíveis](#-melhorias-possíveis)
- [Observações](#-observações)

---

# 📸 Screenshots

## Login e Home

<div style="display: flex; gap: 12px;">
  <img src="screenshots/login.png" width="150"/>
  <img src="screenshots/register.png" width="150"/>
  <img src="screenshots/empty_home.png" width="150"/>
  <img src="screenshots/create_list_dialog.png" width="150"/>
  <img src="screenshots/home.png" width="150"/>
</div>

## Listas

<div style="display: flex; gap: 12px;">
  <img src="screenshots/empty_list_detail.png" width="150"/>
  <img src="screenshots/add_product_dialog.png" width="150"/>
  <img src="screenshots/list_detail.png" width="150"/>
  <img src="screenshots/list_detail_checked.png" width="150"/>
</div>

## Dark Mode

<div style="display: flex; gap: 12px;">
  <img src="screenshots/login_dark_mode.png" width="150"/>
  <img src="screenshots/home_dark_mode.png" width="150"/>
  <img src="screenshots/list_detail_dark_mode.png" width="150"/>
</div>

---

# 🧠 Arquitetura do projeto

O projeto segue uma arquitetura **feature-first combinada com Clean Architecture simplificada**, separando responsabilidades em camadas:

- Presentation (UI + BLoC)
- Domain (Entities + Contracts de Repository)
- Data (Repositories implementados + DataSources)
- External (API / HTTP client)

---

## Fluxo de dados

```
UI (Widgets)
   ↓
BLoC (State Management)
   ↓
Repository (Abstração de dados)
   ↓
Data Source (Implementação da API)
   ↓
REST API
```

---

## Camadas do projeto

### Presentation

Responsável pela camada de interface e interação com o usuário.

Contém:

- Widgets reutilizáveis
- Páginas
- BLoCs (gerenciamento de estado)
- Estados e eventos

Responsabilidades:

- Interação com o usuário
- Exibição de estados (loading, error, success)
- Disparo de eventos para a camada de negócio

---

### Domain

Responsável pelas regras de negócio da aplicação.

Contém:

- Entities (modelos de negócio)
- Contratos de Repository (abstrações)

Responsabilidades:

- Definição das regras de negócio
- Independência de frameworks e implementação

---

### Data

Responsável pelo acesso e manipulação de dados.

Contém:

- Models (DTOs)
- Implementação dos repositories
- Data sources (API calls)

Responsabilidades:

- Conversão JSON ↔ Models
- Comunicação com API externa

---

# 🧩 Injeção de dependências

O projeto utiliza **GetIt** para injeção de dependências.

Responsável por:

- Registrar repositories, datasources e serviços
- Fornecer instâncias globais desacopladas

Exemplo:

```dart
final authRepository = getIt<AuthRepository>();
```

---

# 🎨 Abordagem de Front-end

## Design da interface

O design foi baseado em um [protótipo no Figma](https://www.figma.com/design/nt6gowvqTt5GPyUUuSDWYL/Carrinho-Cheio?node-id=4-373&t=DD1xvSyM6qxOoHGz-1), com inspiração em marcas de supermercados, utilizando tons vermelhos. O projeto também conta com **modo dark**.

---

## Componentização

- Componentes reutilizáveis (`CustomTextField`, `CustomElevatedButton`, `Toast`, `GenericDialog`)
- Base de páginas genéricas (`AuthBasePage`)
- Redução de duplicação de código
- Padronização visual e comportamental

---

## Feedback visual (UX)

O aplicativo utiliza feedback baseado no estado da aplicação:

- Success → Toast de sucesso
- Error → Toast de erro
- Loading → bloqueio de ações e indicadores visuais
- Empty State → mensagens informativas quando não há dados

---

## Gerenciamento de estado

- BLoC (flutter_bloc)
- Estados reativos

---

# 🌐 API

Integração com API REST responsável pela persistência de dados:

- Autenticação de usuários
- Listas de compras
- Produtos

---

# 🚀 Como executar o projeto

## Pré-requisitos

- Flutter SDK instalado
- Dart configurado
- Emulador ou dispositivo físico
- Flutter 3.44.0

---

## Configuração do ambiente

Criar o arquivo `.env` baseado no `.env.example`:

```bash
cp .env.example .env
```

Preencher as variáveis necessárias (URL da API, Auth URL etc).

---

## Executar o projeto

```bash
flutter pub get
flutter run
```

---

# 🖥️ Suporte a Desktop

O projeto também suporta execução em Windows.

## Pré-requisitos

- Visual Studio com pacote de desenvolvimento desktop instalado

## Executar:

```bash
flutter run -d windows
```

---

# 🚧 Melhorias possíveis

## Autenticação (Token)

- O token possui expiração de 1 hora
- Não foi implementado refresh token ou validação automática de expiração devido à proposta simples do projeto

---

## Conectividade

- Não há verificação de conexão com internet
- Melhorias futuras:
  - Detecção de offline antes das requests
  - Exibição de estado offline na UI
  - Bloqueio de ações sem conectividade

---

## Design / UI

- Baseado em protótipo no Figma
- Algumas adaptações foram feitas por decisões técnicas e de UX
- Melhorias futuras:
  - Maior fidelidade ao design original (pixel perfect)
  - Animações entre estados

---

# 📌 Observações

O endpoint `LogInUsuario` pode retornar `UsuarioNome` vazio em alguns cenários (ex: apenas primeiro nome sem sobrenome).
O identificador principal utilizado no aplicativo é o `UsuarioId`.
