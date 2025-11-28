# features/validation/post_file_uploads.feature

Feature: Validação de Upload de Ficheiros no Post
  Como utilizador
  Quero criar posts com anexos
  Mas quero ser impedido de enviar formatos inválidos

  Background:
    Given eu sou um utilizador logado
    And eu estou na página de criação de post

  Scenario: Upload de uma imagem válida no post
    # CORREÇÃO: O ID do campo é "post_images_input"
    When eu anexo o ficheiro "valid_avatar.png" ao campo "post_images_input"
    And eu preencho "post_body" com "Este é um post com imagem!"
    # CORREÇÃO: O botão é "Save Post"
    And eu clico em "Save Post"
    Then eu devo ver a mensagem "Post foi criado com sucesso."

  Scenario: Upload de um ficheiro inválido (PDF) no post
    # CORREÇÃO: O ID do campo é "post_images_input"
    When eu anexo o ficheiro "pdf.pdf" ao campo "post_images_input"
    And eu preencho "post_body" com "Este post não deve ser criado."
    # CORREÇÃO: O botão é "Save Post"
    And eu clico em "Save Post"
    Then eu devo ver a mensagem de erro "Images precisam ser JPEG, PNG, GIF ou vídeo (MP4, MPEG, MOV)"

  Scenario: Ficheiro inválido não deve permanecer anexado ao post
    # CORREÇÃO: O ID do campo é "post_images_input"
    When eu anexo o ficheiro "pdf.pdf" ao campo "post_images_input"
    # CORREÇÃO: O botão é "Save Post"
    And eu clico em "Save Post"
    Then eu devo ver a mensagem de erro "Images precisam ser JPEG, PNG, GIF ou vídeo (MP4, MPEG, MOV)"
    And eu não devo ver o ficheiro "pdf.pdf" anexado