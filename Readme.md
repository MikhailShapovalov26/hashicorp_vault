# Команды для инициализации VAULT

	vault status
	vault operator init
	vault operator unseal

Необходимо ввести 3 ключа

	vault login
	Token (will be hidden):

	vault secrets enable kv
	vault kv put kv/rahasak ops=lambda
	vault kv get kv/rahasak

❯❯ curl \
    -H "X-Vault-Token: hvs.rcvW1OV6gEZBMAopzLnFW850" \
    -H "Content-Type: application/json" \
    -X POST \
    -d '{ "data": { "ops": "koko" } }' \
    http://192.168.88.8:8200/v1/kv/bassa


# get secret with HTTP API
❯❯ curl \
    -H "X-Vault-Token: hvs.rcvW1OV6gEZBMAopzLnFW850" \
    -H "Content-Type: application/json" \
    -X GET \
    http://192.168.88.8:8200/v1/kv/bassa


https://medium.com/rahasak/run-hashicorp-vault-on-docker-with-filesystem-and-consul-backends-a67a7c958e02	
