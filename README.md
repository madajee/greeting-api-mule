# Greeting API Mule Application

This is a Mule 4 application that implements a RESTful API for greeting services using APIkit and following best practices for configuration management and deployment.

## Overview

The Greeting API provides three endpoints:
- `/api/v1/hello` - Returns a greeting message with optional name parameter
- `/api/v1/goodbye` - Returns a goodbye message
- `/api/v1/patients` - Returns a patient-specific greeting with optional name parameter

## Architecture

The application follows these best practices:

### APIkit Integration
- Uses APIkit router for automatic flow generation from RAML specification
- Implements comprehensive exception handling for API-related errors
- Provides API console for testing at `/console`

### Configuration Management
- Uses external `properties.yaml` file for default configuration
- Designed for property override at deployment time via Anypoint Runtime Manager
- No environment-specific configuration files packaged in the application

### DataWeave Best Practices
- External DataWeave files for clean XML and reusable transformations
- Located in `src/main/resources/dwl/` directory
- Proper null handling and default values

### Flow Design
- Clear separation of concerns with dedicated flows for each endpoint
- Comprehensive logging for monitoring and debugging
- Global exception handling strategy

## API Endpoints

### GET /api/v1/hello
Returns a personalized or default greeting message.

**Query Parameters:**
- `name` (optional): The name to include in the greeting

**Response:**
```json
{
  "message": "Hello John!!!"
}
```

**Default Response (no name provided):**
```json
{
  "message": "Hello stranger!!!"
}
```

### GET /api/v1/goodbye
Returns a goodbye message.

**Response:**
```json
{
  "message": "Goodbye stranger!!!"
}
```

### GET /api/v1/patients
Returns a patient-specific greeting message.

**Query Parameters:**
- `name` (optional): The patient name to include in the greeting

**Response:**
```json
{
  "message": "Hello patient Alice!!!"
}
```

**Default Response (no name provided):**
```json
{
  "message": "Hello patient stranger!!!"
}
```

## Configuration

### Default Properties (properties.yaml)

The application uses the following default configuration:

```yaml
# HTTP Listener Configuration
http:
  host: "0.0.0.0"
  port: "8081"
  basePath: "/api/v1"

# API Configuration
api:
  name: "greeting-api"
  version: "1.0.0"
  title: "Greeting API"
  description: "Backend API example for greeting services"

# Application Configuration
app:
  environment: "dev"
  logLevel: "INFO"
```

### Runtime Manager Override

When deploying to Anypoint Runtime Manager, you can override any property:

1. In Runtime Manager, go to your application settings
2. Navigate to Properties tab
3. Add/override properties as needed:
   - `http.port` - Change the listening port
   - `http.host` - Change the host binding
   - `app.logLevel` - Adjust logging level
   - Any other property from the YAML file

## Project Structure

```
src/
├── main/
│   ├── mule/
│   │   └── greeting-api-mule.xml          # Main application flows
│   └── resources/
│       ├── api/
│       │   ├── greeting-api.raml          # API specification
│       │   └── greeting-api.yaml          # OpenAPI specification
│       ├── dwl/
│       │   ├── hello-response.dwl         # Hello endpoint transformation
│       │   ├── goodbye-response.dwl       # Goodbye endpoint transformation
│       │   └── patient-response.dwl       # Patient endpoint transformation
│       ├── properties.yaml               # Default configuration
│       └── log4j2.xml                     # Logging configuration
└── test/
    └── resources/
        └── log4j2-test.xml               # Test logging configuration
```

## Dependencies

The application uses the following key dependencies:

- **Mule Runtime**: 4.9.6
- **HTTP Connector**: 1.10.3
- **APIkit Module**: 1.11.3
- **Sockets Connector**: 1.2.5

## Running the Application

### Local Development

1. Import the project into Anypoint Studio
2. Run the application
3. Access the API at `http://localhost:8081/api/v1/`
4. Access the API console at `http://localhost:8081/console/`

### Testing Endpoints

```bash
# Test hello endpoint without name
curl http://localhost:8081/api/v1/hello

# Test hello endpoint with name
curl "http://localhost:8081/api/v1/hello?name=John"

# Test goodbye endpoint
curl http://localhost:8081/api/v1/goodbye

# Test patients endpoint without name
curl http://localhost:8081/api/v1/patients

# Test patients endpoint with name
curl "http://localhost:8081/api/v1/patients?name=Alice"
```

## Error Handling

The application implements comprehensive error handling for:

- **400 Bad Request**: Invalid request format
- **404 Not Found**: Resource not found
- **405 Method Not Allowed**: HTTP method not supported
- **406 Not Acceptable**: Content type not acceptable
- **415 Unsupported Media Type**: Media type not supported
- **501 Not Implemented**: Endpoint not implemented
- **500 Internal Server Error**: Unexpected errors

All error responses follow a consistent format:

```json
{
  "message": "Error description",
  "details": "Detailed error information",
  "timestamp": "2024-01-01T12:00:00Z",
  "status": 400
}
```

## Deployment Best Practices

1. **Property Management**: Use Runtime Manager to override properties for different environments
2. **Monitoring**: Enable application logs and monitoring in Runtime Manager
3. **Security**: Configure HTTPS and security policies as needed
4. **Scaling**: Configure worker size and count based on expected load

## Development Guidelines

1. **DataWeave**: Keep transformations in external files for maintainability
2. **Logging**: Use appropriate log levels and include relevant context
3. **Error Handling**: Implement comprehensive error handling for all scenarios
4. **Testing**: Test all endpoints and error conditions
5. **Documentation**: Keep API documentation up to date with implementation

## API Console

The application provides an interactive API console accessible at `/console` that allows you to:

- Explore the API specification
- Test endpoints directly from the browser
- View request/response examples
- Understand the API structure and parameters