const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "ap-southeast-2:80ee744c-4111-4f52-905a-53741570ed21",
                            "Region": "ap-southeast-2"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "ap-southeast-2_ZuNxL4PSz",
                        "AppClientId": "68njc0v80lhg5vhdsjnflpt2ua",
                        "AppClientSecret": "uegfdgb7t81t4h7hveenrs9b6urvbkgo44srs9ufscr8c6tlvkn",
                        "Region": "ap-southeast-2"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH"
                    }
                },
                "S3TransferUtility": {
                    "Default": {
                        "Bucket": "photogallery2026f5a4faae40cebd58f6a8278217f2155336-dev",
                        "Region": "ap-southeast-2"
                    }
                },
                "PinpointAnalytics": {
                    "Default": {
                        "AppId": "d604e93a93fa4aed88687ff8aec55bab",
                        "Region": "us-west-2"
                    }
                },
                "PinpointTargeting": {
                    "Default": {
                        "Region": "us-west-2"
                    }
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "photogallery2026f5a4faae40cebd58f6a8278217f2155336-dev",
                "region": "ap-southeast-2",
                "defaultAccessLevel": "guest"
            }
        }
    },
    "analytics": {
        "plugins": {
            "awsPinpointAnalyticsPlugin": {
                "pinpointAnalytics": {
                    "appId": "d604e93a93fa4aed88687ff8aec55bab",
                    "region": "us-west-2"
                },
                "pinpointTargeting": {
                    "region": "us-west-2"
                }
            }
        }
    }
}''';
