#ifndef CERT_TRANS_MERKLETREE_SERIAL_HASHER_H_
#define CERT_TRANS_MERKLETREE_SERIAL_HASHER_H_

#include <openssl/sha.h>
#include <stddef.h>
#include <memory>
#include <string>

class SerialHasher {
 public:
  SerialHasher() = default;
  virtual ~SerialHasher() = default;
  SerialHasher(const SerialHasher&) = delete;
  SerialHasher& operator=(const SerialHasher&) = delete;

  virtual size_t DigestSize() const = 0;

  // Reset the context. Must be called before the first Update() call.
  // Optionally it can be called after each Final() call; however
  // doing so is a no-op since Final() will leave the hasher in a
  // reset state.
  virtual void Reset() = 0;

  // Update the hash context with (binary) data.
  virtual void Update(const std::string& data) = 0;

  // Finalize the hash context and return the binary digest blob.
  virtual std::string Final() = 0;

  // A virtual constructor, creates a new instance of the same type.
  virtual std::unique_ptr<SerialHasher> Create() const = 0;
};

#endif  // CERT_TRANS_MERKLETREE_SERIAL_HASHER_H_
