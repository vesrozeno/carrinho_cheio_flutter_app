# Carrinho Cheio

Este projeto consiste em um aplicativo mobile desenvolvido em Flutter que permite aos usuários criar e gerenciar listas de compras. O sistema conta com autenticação, criação de listas, adição e remoção de itens, marcação de produtos como comprados e integração com uma [API REST](https://listadella.azurewebsites.net/apiListadella_desafio.yaml/swagger/index.html) para persistência dos dados.

### Abordagem de desenvolvimento adotada:

- Arquitetura baseada em features (feature-first) e organizada em camadas (presentation, domain, data)
- Gerenciamento de estado via BLoC
- Abstração de acesso a dados usando repository pattern
- Injeção de dependências utilizando GetIt

### Design da interface

Foi criado um [protótipo no Figma](https://www.figma.com/design/nt6gowvqTt5GPyUUuSDWYL/Carrinho-Cheio?node-id=0-1&t=UvlobzF1IUrlkprK-1) para melhor guiar o desenvolvimento. As inspirações foram marcas de supermercados, com tons vermelhos.

### Observações:

- O endpoint LogInUsuario retorna o campo UsuarioNome vazio em alguns cenários (Quando há apenas um nome, sem sobrenome),
  mesmo após o cadastro bem-sucedido. O aplicativo utiliza o UsuarioId como identificador principal do usuário.
