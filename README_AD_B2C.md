# Azure AD b2c 

Azure AD b2c is not completely compatible with terraform and some of the setup has been done via the portal. To explain in a bit more detail this diagram shows which parts are terraformed and the instructions for the Identity Experience Framework setup are below;
![](./bin/Azure%20serverless%20web%20app%20UCAN.png)

# Getting started

#### Provisioning everything, is currently not supported by terraform, we have been adding the templates via the Azure portal.
### Setting up Azure B2C domain
Setup B2C tenant


1 - Run the terraform to create a tenant. 
2 - Switch to new tenant using the scan user
3 - Create an App registration 

Register the spa app (Development/Staging/Production)
1. Navigate to the Azure portal and select the Azure AD B2C service.
2. Select the App Registrations blade on the left, then select New registration.
3. In the Register an application page that appears, enter your application's registration information:
    * In the Name section, enter a meaningful application name that will be displayed to users of the app, for example Development/Staging/Production.
    * Under Supported account types, select Accounts in any identity provider or organizational directory (for authenticating users with user flows).
    * In the Redirect URI section, select Single-page application in the combo-box and enter the following redirect URI: http://localhost:3000 for development and staging/production urls for Environments.
4. Select Register to create the application.
5. In the app's registration screen, find and note the Application (client) ID. You use this value in your app's configuration file(s) later in your code.
6. Select Save to save your changes.

### Azure AD b2c Identity Experience Framework

Azure provides its own framework for building out templates for its OAuth offering. 
- [A small side not to see the ADRs in notion of why we had to choose Azure AD b2c, as its not the easiest to learn.] 

- Read through the docs and samples by microsoft here [identity-experience-framework-azure-ad](https://docs.microsoft.com/en-us/samples/azure-samples/active-directory-b2c-advanced-policies/identity-experience-framework-azure-ad/)

### Adding/Updating templates
- Changes to templates can made locally and uploaded to github for tracking purposes.
- Using the azure portal you can upload, validate and run tests.
- Its possible to use this [Azure site](https://b2ciefsetupapp.azurewebsites.net/) to auto deploy some ready made templates. You may need to setup a user within the Ad b2c domain explained [here](https://medium.com/the-new-control-plane/a-utility-to-deploy-azure-ad-aad-b2c-ief-starter-pack-policies-automatically-1836a61cc6bc)
- Unfortunately the samples were not exactly what was needed for this project. So they have been customized to support passwordless login for both email, phone and social logins. 

### First time uploading the templates requires a specific order of configuration
- TrustFrameworkBase.xml (This should already exist from the auto deploy setup above.)
- PhoneEmailCustomBase.xml
- SignUpOrSignInWithPhoneOrEmailCustom.xml


### Setting up social login providers info
- Current credentials in 1Password
- [facebook](https://docs.microsoft.com/en-us/azure/active-directory-b2c/identity-provider-facebook?pivots=b2c-custom-policy)
- [google](https://docs.microsoft.com/en-us/azure/active-directory-b2c/identity-provider-google?pivots=b2c-custom-policy)


### Debugging template errors. 
- For staging: we have setup an application insights instance and linked it to the SignUpOrSignInWithPhoneOrEmailCustom file using the InstrumentationKey, instructions on how to set that up [here](https://docs.microsoft.com/en-us/azure/active-directory-b2c/troubleshoot-with-application-insights?pivots=b2c-custom-policy)
