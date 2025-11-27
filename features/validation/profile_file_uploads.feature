# features/validation/file_uploads.feature

Feature: Validação de Upload de Ficheiros no Perfil
  Como utilizador
  Quero fazer upload de ficheiros no meu perfil
  Mas quero ser impedido de enviar formatos inválidos

  Background:
    Given eu sou um utilizador logado
    And eu estou na página de edição do meu perfil

  Scenario: Upload de um avatar com formato de imagem válido
    When eu anexo o ficheiro "valid_avatar.png" ao campo "profile_avatar"
    # CORREÇÃO: O botão é "Save Profile"
    And eu clico em "Save Profile"
    Then eu devo ver a mensagem "Perfil foi atualizado com sucesso."

  Scenario: Upload de um avatar com formato inválido (PDF)
    When eu anexo o ficheiro "pdf.pdf" ao campo "profile_avatar"
    # CORREÇÃO: O botão é "Save Profile"
    And eu clico em "Save Profile"
    Then eu devo ver a mensagem de erro "Os arquivos do perfil devem ser JPEG, PNG, GIF ou vídeo (MP4, MPEG, MOV)"

  Scenario: Ficheiro inválido não deve permanecer anexado
    When eu anexo o ficheiro "pdf.pdf" ao campo "profile_avatar"
    # CORREÇÃO: O botão é "Save Profile"
    And eu clico em "Save Profile"
    Then eu devo ver a mensagem de erro "Os arquivos do perfil devem ser JPEG, PNG, GIF ou vídeo (MP4, MPEG, MOV)"
    And eu não devo ver o ficheiro "pdf.pdf" anexado