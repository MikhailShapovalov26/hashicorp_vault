# Команды для инициализации VAULT

	vault status
	vault operator init
	vault operator unseal

Необходимо ввести 3 ключа

### login to vault with root token(in this case s.5VHXQu45QGKfpZhQ23wn0OiA)
	vault login
	Token (will be hidden):

	vault secrets enable kv
### create new secret with a key of `ops` and value of `lambda` within the `kv/rahasak` path

Сдлеает секрет для работы key и value
- vault kv put kv/rahsak password=password

	vault kv put kv/rahasak ops=lambda

Проверить верность заданных ключей и значений

	vault kv get kv/rahasak

Запросить только значение
 
    vault kv get -field=password kv/rahsak

❯❯ curl \
    -H "X-Vault-Token: ROOT SECRET" \
    -H "Content-Type: application/json" \
    -X POST \
    -d '{ "data": { "ops": "koko" } }' \
    http://192.168.88.8:8200/v1/kv/bassa


# get secret with HTTP API
❯❯ curl \
    -H "X-Vault-Token:  ROOT SECRET" \
    -H "Content-Type: application/json" \
    -X GET \
    http://192.168.88.8:8200/v1/kv/bassa


https://medium.com/rahasak/run-hashicorp-vault-on-docker-with-filesystem-and-consul-backends-a67a7c958e02	


Разрешим для нашего Vault-сервера метод аутентификации через JWT:

    vault auth enable jwt

Создаем policy, которые дают доступ на чтение к нужным нам секретам:

    vault policy write myproject - <<EOF
    # Policy name: myproject
    #
    # Read-only permission on 'kv/rahsak/*' path
    path "kv/rahsak/*" {
    capabilities = [ "read" ]
    }
    EOF
Success! Uploaded policy: myproject

EOF на 0 уровне без отступов

Теперь нам надо роли которые будут связываать созданнве политики с JWT-tokenom ("policies": ["myproject"] создали выше)
1. Создадим роль test

    vault write auth/jwt/role/test - <<EOF
    {
    "role_type": "jwt",
    "policies": ["myproject"],
    "token_explicit_max_ttl": 60,
    "user_claim": "user_email",
    "bound_claims": {
        "project_id": "22",
        "ref": "master",
        "ref_type": "branch"
    }
    }
    EOF

Теперь зададим метод аутентификации через JWT:

    vault write auth/jwt/config \
        jwks_url="https://gitlab.example.com/-/jwks" \
        bound_issuer="gitlab.example.com"

Так как runner и vault установлены локально для тестов необходимо установить соединение между ними, создадим сеть в которую включил runner и vault для чтения секретов

    ~ » docker network create vault-runner
    ~ » docker network connect vault-runner runner
    ~ » docker network connect vault-runner vault 

Материал взять https://habr.com/ru/companies/nixys/articles/512754/ про значения можно посмотреть там!
https://docs.gitlab.com/ee/ci/secrets/