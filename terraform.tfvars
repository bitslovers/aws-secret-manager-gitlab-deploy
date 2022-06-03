REGION             = "us-east-1"

SECRETS_LIST = {

    db-blog = {
      description = "Blog Credentials"
      secret_key_value = {
        username = "blog"
        password = "blog"
      }
    },

    db-app = {
      description = "App Credentials"
      secret_key_value = {
        username = "app"
        password = "app"
      }
    }

   
  }