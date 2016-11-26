# About the project.

I have another project that is the awesome4girls where I've been collecting
projects and initiatives about diversity. I've decided to created an api
for this project and persist all this data in a Database providing it as
json

## Architecture
 - Framework
 As it is a simple json api and I think it will not grow up to much
 I picked Sinatra because it is simple and robust framework. Also it
 has a good support for extensions.
 Rails is great but I think it is too much for this soluction.

 - Database
 I picked postgress sql cause it is a great opens source SQL database and it
 has a well known integration with ActiveRecord

 - App Structure
 I did it as a MVC Architecture cause it is simple to understand and is good
 for mantaining

 - Authentication
 It uses the Basic Authentication scheme specified in https://tools.ietf.org/html/rfc2617
