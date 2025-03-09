# First build guidance
## If you don't follow this guidance, you'll probably encounter some errors which are not extremely verbose, and you'll probably end up confused.

* Run `asphalt init` before attempting to build via `lune run dev`. In order to run the lune script, the `asphalt.toml` file must exist, which it will not until you init asphalt. This is not done within this repository as it requires a user/group id in order to upload to the cloud,
* If you're using selene, make sure to configure that yourself, as it's excluded from the project as a personal configuration file,
* This project comes default with Fusion, my personal choice for a UI library. If you don't want to use Fusion, you don't have to,
* Follow the [asphalt](https://github.com/jackTabsCode/asphalt?tab=readme-ov-file#readme) and [mantle](https://mantledeploy.vercel.app/docs/getting-started) documentation to set them up,
* The lune scripts do the following
    * `build` will sync asphalt, build the project and output it to `dev.rbxl`,
    * `dev` will do the same, but it will also open `dev.rbxl`, aswell as serve rojo,
    * `deploy` will run `mantle deploy` and publish to the game specified. **You must setup `mantle.yml` with the group/user id, aswell as the correct label in order for this to work. Otherwise it simply will not.**
* Delete this `README.md` file to avoid confusion.

This isn't required, but you should replace **TEMPLATE_NAME** with the project name within `default.project.json`.
