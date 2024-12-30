webapp_environment = {
  "production" = {
    serviceplan={
        serviceplan500={
            sku= "F1"
            os_type="Windows"
        }
    }
    serviceapp={
        webapp5000010="serviceplan500"
    }
  }
}