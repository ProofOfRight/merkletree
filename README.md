# Merkle Tree Implementation

This repository contains [merkle tree](https://en.wikipedia.org/wiki/Merkle_tree) implementation, taken from Google's [Certificate Transparency](https://github.com/google/certificate-transparency) project.

Following parts of the original repository are taken:
* Merkle Tree implementation
* Serial Hasher and Tree Hasher interfaces

## Usage

Merkle Tree requires SerialHasher implementation, which uses some hash function to provide Update(), Final(), Reset() and DigestSize() methods. You can use Sha256Hasher in serial_hasher as a reference implementation.
