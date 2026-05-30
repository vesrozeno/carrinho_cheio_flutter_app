# Carrinho Cheio

Este projeto consiste em um aplicativo mobile desenvolvido em Flutter que permite aos usuários criar e gerenciar listas de compras. O sistema conta com autenticação, criação de listas, adição e remoção de itens, marcação de produtos como comprados e integração com uma API REST para persistência dos dados.

### Abordagem de desenvolvimento adotada:

- Arquitetura baseada em features (feature-first) e organizada em camadas (presentation, domain, data)
- Gerenciamento de estado via BLoC
- Abstração de acesso a dados usando repository pattern
- Navegação utilizando GoRouter
- Injeção de dependências utilizando GetIt

Observação:
O endpoint LogInUsuario retorna o campo UsuarioNome vazio em alguns cenários (Quando há apenas um nome, sem sobrenome),
mesmo após o cadastro bem-sucedido. O aplicativo utiliza o UsuarioId como
identificador principal do usuário.
