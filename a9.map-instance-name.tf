variable "cartypes" {
  description = "map of the instance size with different environment"
  type        = map(string) #dictionary of string values
  default = {
    "audi"     = "vwg",   #1 core processor and 1 Gb of RAM
    "bentley" = "vwg",    #2 core 4 GB RAM
  }
}