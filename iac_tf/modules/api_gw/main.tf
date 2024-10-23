resource "aws_api_gateway_rest_api" "url_shortener_api" {
  name        = var.api_gateway_name
  description = "API Gateway for URL Shortener Service"
}

resource "aws_api_gateway_resource" "url" {
  rest_api_id = aws_api_gateway_rest_api.url_shortener_api.id
  parent_id   = aws_api_gateway_rest_api.url_shortener_api.root_resource_id
  path_part   = "url"
}

resource "aws_api_gateway_method" "get_url_method" {
  rest_api_id   = aws_api_gateway_rest_api.url_shortener_api.id
  resource_id   = aws_api_gateway_resource.url.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "get_url_method_response" {
  rest_api_id = aws_api_gateway_rest_api.url_shortener_api.id
  resource_id = aws_api_gateway_resource.url.id
  http_method = aws_api_gateway_method.get_url_method.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration" "url_integration" {
  rest_api_id = aws_api_gateway_rest_api.url_shortener_api.id
  resource_id = aws_api_gateway_resource.url.id
  http_method = aws_api_gateway_method.get_url_method.http_method
  type        = "HTTP_PROXY"
  uri         = "http://your-flask-app-load-balancer-or-ec2-url"  # Update this with your service URL

  integration_http_method = "ANY"
}

resource "aws_api_gateway_deployment" "url_shortener_deployment" {
  depends_on = [aws_api_gateway_integration.url_integration]
  rest_api_id = aws_api_gateway_rest_api.url_shortener_api.id
  stage_name  = "v1"
}