#!/usr/local/bin/python3

from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.asymmetric import padding

message = b"A message I want to sign"
private_key = load_privateKey("/home/toto/crypto/key2.pem")

def load_privateKey(path):
    with open(path, 'rb') as f:
        pem_data = f.read()
    return serialization.load_pem_private_key(pem_data, password=b"passphrase")

signature = private_key.sign(
    message,
    padding.PSS(
        mgf=padding.MGF1(hashes.SHA256()),
        salt_length=padding.PSS.MAX_LENGTH
    ),
    hashes.SHA256()
)

print(base64.b64encode(signature))