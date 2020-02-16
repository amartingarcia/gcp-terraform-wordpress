output "kms_ring" {
  value = google_kms_key_ring.key_ring
}

output "kms_crypto" {
  value = google_kms_crypto_key.crypto_key
}