terraform {
  cloud {
    organization = "lab-Apr" # 스크린샷의 조직 이름

    workspaces {
      name = "frontbackn-dev-cli" # 스크린샷의 워크스페이스 이름
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}
