AWSTemplateFormatVersion: "2010-09-09"
Metadata:
    Generator: "former2"
Description: ""
Resources:
    S3Bucket:
        Type: "AWS::S3::Bucket"
        Properties:
            BucketName: "isaacs-douglas-cloud-resume"
            BucketEncryption: 
                ServerSideEncryptionConfiguration: 
                  - 
                    ServerSideEncryptionByDefault: 
                        SSEAlgorithm: "AES256"
                    BucketKeyEnabled: true
            OwnershipControls: 
                Rules: 
                  - 
                    ObjectOwnership: "BucketOwnerEnforced"
            PublicAccessBlockConfiguration: 
                BlockPublicAcls: true
                BlockPublicPolicy: true
                IgnorePublicAcls: true
                RestrictPublicBuckets: true

    S3Bucket2:
        Type: "AWS::S3::Bucket"
        Properties:
            BucketName: !Sub "${S3Bucket}-lambda-functions"
            BucketEncryption: 
                ServerSideEncryptionConfiguration: 
                  - 
                    ServerSideEncryptionByDefault: 
                        SSEAlgorithm: "AES256"
                    BucketKeyEnabled: true
            OwnershipControls: 
                Rules: 
                  - 
                    ObjectOwnership: "BucketOwnerEnforced"
            PublicAccessBlockConfiguration: 
                BlockPublicAcls: true
                BlockPublicPolicy: true
                IgnorePublicAcls: true
                RestrictPublicBuckets: true

    S3BucketPolicy:
        Type: "AWS::S3::BucketPolicy"
        Properties:
            Bucket: !Ref S3Bucket
            PolicyDocument: 
                Version: "2008-10-17"
                Id: "PolicyForCloudFrontPrivateContent"
                Statement: 
                  - 
                    Sid: "AllowCloudFrontServicePrincipal"
                    Effect: "Allow"
                    Principal: 
                        Service: "cloudfront.amazonaws.com"
                    Action: "s3:GetObject"
                    Resource: !Sub "arn:aws:s3:::${S3Bucket}/*"
                    Condition: 
                        StringEquals: 
                            "AWS:SourceArn": !Sub "arn:aws:cloudfront::${AWS::AccountId}:distribution/${CloudFrontDistribution}"

    LambdaFunction:
        Type: "AWS::Lambda::Function"
        Properties:
            Description: ""
            FunctionName: "CloudResumeAddVisitor"
            Handler: "addvisitor.lambda_handler"
            Architectures: 
              - "x86_64"
            Code: 
                S3Bucket: "awslambda-ap-se-2-tasks"
                S3Key: !Sub "/snapshots/${AWS::AccountId}/CloudResumeAddVisitor-fbdeb0fa-ed2b-45a6-b13c-b3bb3dba6782"
                S3ObjectVersion: "mxc7xrBHzfkUVtEZhmiS8s6UF_9hLJME"
            MemorySize: 128
            Role: !GetAtt IAMRole.Arn
            Runtime: "python3.9"
            Timeout: 3
            TracingConfig: 
                Mode: "PassThrough"
            EphemeralStorage: 
                Size: 512

    LambdaFunction2:
        Type: "AWS::Lambda::Function"
        Properties:
            Description: ""
            FunctionName: "CloudResumeGetVisitor"
            Handler: "getvisitor.lambda_handler"
            Architectures: 
              - "x86_64"
            Code: 
                S3Bucket: "awslambda-ap-se-2-tasks"
                S3Key: !Sub "/snapshots/${AWS::AccountId}/CloudResumeGetVisitor-ce6a45fe-be9c-4fd7-b336-e03f0825c98e"
                S3ObjectVersion: "5x4vcKGrBQg58dpcnzmLEUmM7mHtWk.w"
            MemorySize: 128
            Role: !GetAtt IAMRole.Arn
            Runtime: "python3.9"
            Timeout: 3
            TracingConfig: 
                Mode: "PassThrough"
            EphemeralStorage: 
                Size: 512

    LambdaPermission:
        Type: "AWS::Lambda::Permission"
        Properties:
            Action: "lambda:InvokeFunction"
            FunctionName: !GetAtt LambdaFunction.Arn
            Principal: "apigateway.amazonaws.com"
            SourceArn: !Sub "arn:aws:execute-api:${AWS::Region}:${AWS::AccountId}:${ApiGatewayV2Api}/*/*/"

    LambdaPermission2:
        Type: "AWS::Lambda::Permission"
        Properties:
            Action: "lambda:InvokeFunction"
            FunctionName: !GetAtt LambdaFunction2.Arn
            Principal: "apigateway.amazonaws.com"
            SourceArn: !Sub "arn:aws:execute-api:${AWS::Region}:${AWS::AccountId}:${ApiGatewayV2Api}/*/*/"

    ApiGatewayV2Api:
        Type: "AWS::ApiGatewayV2::Api"
        Properties:
            ApiKeySelectionExpression: "$request.header.x-api-key"
            ProtocolType: "HTTP"
            RouteSelectionExpression: "$request.method $request.path"
            CorsConfiguration: 
                AllowCredentials: false
                AllowHeaders: 
                  - "*"
                AllowMethods: 
                  - "GET"
                  - "POST"
                  - "OPTIONS"
                AllowOrigins: 
                  - "https://www.isaac-douglas.com"
                ExposeHeaders: 
                  - "*"
                MaxAge: 3600
            DisableExecuteApiEndpoint: false

    DynamoDBTable:
        Type: "AWS::DynamoDB::Table"
        Properties:
            AttributeDefinitions: 
              - 
                AttributeName: "record_id"
                AttributeType: "S"
            TableName: "Visitor_Count"
            KeySchema: 
              - 
                AttributeName: "record_id"
                KeyType: "HASH"
            ProvisionedThroughput: 
                ReadCapacityUnits: 5
                WriteCapacityUnits: 5

    IAMRole:
        Type: "AWS::IAM::Role"
        Properties:
            Path: "/"
            RoleName: "cloud-resume-lambda-ddb-role"
            AssumeRolePolicyDocument: "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"lambda.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}"
            MaxSessionDuration: 3600
            ManagedPolicyArns: 
              - "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
              - "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
            Description: "Allows Lambda functions to call AWS services on your behalf."

    CloudFrontDistribution:
        Type: "AWS::CloudFront::Distribution"
        Properties:
            DistributionConfig: 
                Aliases: 
                  - "isaac-douglas.com"
                  - "www.isaac-douglas.com"
                Origins: 
                  - 
                    ConnectionAttempts: 3
                    ConnectionTimeout: 10
                    DomainName: !Sub "${S3Bucket}.s3.${AWS::Region}.amazonaws.com"
                    Id: !Sub "${S3Bucket}.s3.${AWS::Region}.amazonaws.com-mk68tbks88q"
                    OriginPath: ""
                    S3OriginConfig: 
                        OriginAccessIdentity: ""
                DefaultCacheBehavior: 
                    AllowedMethods: 
                      - "HEAD"
                      - "GET"
                    CachedMethods: 
                      - "HEAD"
                      - "GET"
                    Compress: true
                    CachePolicyId: "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
                    SmoothStreaming: false
                    TargetOriginId: !Sub "${S3Bucket}.s3.${AWS::Region}.amazonaws.com-mk68tbks88q"
                    ViewerProtocolPolicy: "redirect-to-https"
                Comment: ""
                PriceClass: "PriceClass_All"
                Enabled: true
                ViewerCertificate: 
                    AcmCertificateArn: !Sub "arn:aws:acm:us-east-1:${AWS::AccountId}:certificate/d584e3ef-2279-4e01-b408-c9e8b8b7c331"
                    CloudFrontDefaultCertificate: false
                    MinimumProtocolVersion: "TLSv1.2_2021"
                    SslSupportMethod: "sni-only"
                Restrictions: 
                    GeoRestriction: 
                        RestrictionType: "none"
                WebACLId: !Sub "arn:aws:wafv2:us-east-1:${AWS::AccountId}:global/webacl/CreatedByCloudFront-1973ba31/ddd36137-965b-4baa-98af-b31a063808da"
                HttpVersion: "http2"
                DefaultRootObject: "index.html"
                IPV6Enabled: true

