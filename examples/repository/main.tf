module "info" {
  source  = "Selleo/context/null"
  version = "0.3.0"

  namespace = "kudos"
  stage     = "production"
  name      = "api"
}

module "this" {
  source = "../../modules/repository"

  context = module.info.context
}
