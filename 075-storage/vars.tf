# Storage Variables
variable "storage_location" {
    type = list(string)
    default = ["EU", "US", "ASIA"]
}

variable "storage_type" {
    type = list(string)
    default = ["STANDARD", "MULTI_REGIONAL", "REGIONAL", "NEARLINE", "COLDLINE"]
}

variable "storage_lifecycle_action_type" {
    type = list(string)
    default = ["Delete", "SetStorageClass"]
}

variable "storage_lifecycle_storage_class" {
    type = list(string)
    default = ["STANDARD", "MULTI_REGIONAL", "REGIONAL", "NEARLINE", "COLDLINE"]
}

variable "storage_lifecycle_matches_storage_class" {
    type = list(string)
    default = ["STANDARD", "MULTI_REGIONAL", "REGIONAL", "NEARLINE", "COLDLINE"]
}