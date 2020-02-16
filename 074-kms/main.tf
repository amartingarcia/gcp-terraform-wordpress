resource "google_kms_key_ring" "key_ring" {
  project  = "my-project"
  name     = "my-key-ring"
  location = var.region
}

resource "google_kms_crypto_key" "crypto_key" {
  name     = "my-crypto-key"
  key_ring = google_kms_key_ring.key_ring.self_link

  depends_on = [google_kms_key_ring.key_ring]
}