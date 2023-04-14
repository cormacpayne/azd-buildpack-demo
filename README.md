### `az-buildpack-demo`

This branch contains the changes that enable the following flow:

- Make a change to the .NET Application in the `src` folder
- Run `azd deploy` from the root of this repository
- The Paketo builder will be used to create a new runnable application image locally
- The image will be pushed to the provided ACR instance
- The Container App will be updated with this new image via the `az containerapp update` command

### Prerequisites

The following steps should first be taken before enabling the above flow:

- The [latest version of Go](https://go.dev/doc/install) should be installed
- The changes in the `setup` branch must have been deployed so there is a resource group with your Container App,
Container App environment, and ACR instance
- You only need to keep the `.azure` folder from the `setup` branch's deployment, but the `infra` and `src` folders,
along with the `azure.yaml` file, from this repository should be used with that `.azure` folder to ensure the
environment you previously created is referenced correctly
- The Azure CLI must be installed and the context must be pointing at the subscription that contains the previously
mentioned environment
- The AZD CLI must have been built locally in the `cormacpayne/azure-dev` from the `corm/containerapp-buildpack-demo`
branch
  - Run the `cli/azd/local-build.ps1` script in PowerShell from the given fork and branch to build the CLI locally
  - It's recommended that you change the name of the executable produced in the `cli/azd/build` folder from
  `azd-windows-amd64.exe` to something shorter, such as `azd-demo`
  - It's also recommended that you add the full path to this executable to your `PATH` so it can easily be called from
  the command line
- Update the following values in your local copy of this repository
  - `infra/main.bicep`
    - Line 23: `RESOURCE_GROUP_NAME` is replaced with the resource group that you deployed your demo to
    - Line 28: `CONTAINER_APP_ENVIRONMENT_NAME` is replaced with the name of your Container App environment
    - Line 29: `ACR_NAME` is replaced with the name of your ACR instance