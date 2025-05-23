@0xeae9f1e5c6b90ad2;

using Spk = import "/sandstorm/package.capnp";
# This imports:
#   $SANDSTORM_HOME/latest/usr/include/sandstorm/package.capnp
# Check out that file to see the full, documented package definition format.

const pkgdef :Spk.PackageDefinition = (
  # The package definition. Note that the spk tool looks specifically for the
  # "pkgdef" constant.

  id = "2h1ar1v72kh42vkqs2y73z5u31rdh4cea8vkrk7sjtwhgzm2csfh",
  # Your app ID is actually its public key. The private key was placed in
  # your keyring. All updates must be signed with the same key.

  manifest = (
    # This manifest is included in your app package to tell Sandstorm
    # about your app.

    appTitle = (defaultText = "Simple Help Desk"),

    appVersion = 1,  # Increment this for every release.

    appMarketingVersion = (defaultText = "0.0.1"),
    # Human-readable representation of appVersion. Should match the way you
    # identify versions of your app in documentation and marketing.

    actions = [
      # Define your "new document" handlers here.
      ( nounPhrase = (defaultText = "instance"),
        command = .myCommand
        # The command to run when starting for the first time. (".myCommand"
        # is just a constant defined at the bottom of the file.)
      )
    ],

    continueCommand = .myCommand,
    # This is the command called to start your app back up after it has been
    # shut down for inactivity. Here we're using the same command as for
    # starting a new instance, but you could use different commands for each
    # case.

    metadata = (
      icons = (
        appGrid = (png = (dpi1x = embed "../images/logo.png")),
        grain = (png = (dpi1x = embed "../images/logo.png")),
        market = (png = (dpi1x = embed "../images/logo.png")),
        marketBig = (png = (dpi1x = embed "../images/logo.png")),
      ),

      website = "https://github.com/ocdtrekkie/simple-helpdesk-php",

      codeUrl = "https://github.com/ocdtrekkie/simple-helpdesk-php",

      license = (openSource = mit),

      categories = [communications, developerTools],

      author = (

        contactEmail = "inbox@jacobweisz.com",

        pgpSignature = embed "pgp-signature",
      ),

      pgpKeyring = embed "pgp-keyring",

      #description = (defaultText = embed "path/to/description.md"),
      # The app's description in Github-flavored Markdown format, to be displayed e.g.
      # in an app store. Note that the Markdown is not permitted to contain HTML nor image tags (but
      # you can include a list of screenshots separately).

      shortDescription = (defaultText = "Support tickets"),

      screenshots = [
        (width = 1402, height = 658, png = embed "../screenshot/main.png"),
      ],
      #changeLog = (defaultText = embed "path/to/sandstorm-specific/changelog.md"),
      # Documents the history of changes in Github-flavored markdown format (with the same restrictions
      # as govern `description`). We recommend formatting this with an H1 heading for each version
      # followed by a bullet list of changes.
    ),
  ),

  sourceMap = (
    # Here we defined where to look for files to copy into your package. The
    # `spk dev` command actually figures out what files your app needs
    # automatically by running it on a FUSE filesystem. So, the mappings
    # here are only to tell it where to find files that the app wants.
    searchPath = [
      ( sourcePath = "." ),  # Search this directory first.
      ( sourcePath = "/",    # Then search the system root directory.
        hidePaths = [ "home", "proc", "sys",
                      "etc/passwd", "etc/hosts", "etc/host.conf",
                      "etc/nsswitch.conf", "etc/resolv.conf" ]
        # You probably don't want the app pulling files from these places,
        # so we hide them. Note that /dev, /var, and /tmp are implicitly
        # hidden because Sandstorm itself provides them.
      )
    ]
  ),

  fileList = "sandstorm-files.list",
  # `spk dev` will write a list of all the files your app uses to this file.
  # You should review it later, before shipping your app.

  alwaysInclude = [],
  # Fill this list with more names of files or directories that should be
  # included in your package, even if not listed in sandstorm-files.list.
  # Use this to force-include stuff that you know you need but which may
  # not have been detected as a dependency during `spk dev`. If you list
  # a directory here, its entire contents will be included recursively.

  bridgeConfig = (
    # Used for integrating permissions and roles into the Sandstorm shell
    # and for sandstorm-http-bridge to pass to your app.
    # Uncomment this block and adjust the permissions and roles to make
    # sense for your app.
    # For more information, see high-level documentation at
    # https://docs.sandstorm.io/en/latest/developing/auth/
    # and advanced details in the "BridgeConfig" section of
    # https://github.com/sandstorm-io/sandstorm/blob/master/src/sandstorm/package.capnp
    viewInfo = (
      # For details on the viewInfo field, consult "ViewInfo" in
      # https://github.com/sandstorm-io/sandstorm/blob/master/src/sandstorm/grain.capnp
  
      permissions = [
      # Permissions which a user may or may not possess.  A user's current
      # permissions are passed to the app as a comma-separated list of `name`
      # fields in the X-Sandstorm-Permissions header with each request.
      #
      # IMPORTANT: only ever append to this list!  Reordering or removing fields
      # will change behavior and permissions for existing grains!  To deprecate a
      # permission, or for more information, see "PermissionDef" in
      # https://github.com/sandstorm-io/sandstorm/blob/master/src/sandstorm/grain.capnp
        (
          name = "admin",
          # Name of the permission, used as an identifier for the permission in cases where string
          # names are preferred.  Used in sandstorm-http-bridge's X-Sandstorm-Permissions HTTP header.
  
          title = (defaultText = "admin"),
          # Display name of the permission, e.g. to display in a checklist of permissions
          # that may be assigned when sharing.
  
          description = (defaultText = "ability to administrate the system"),
          # Prose describing what this role means, suitable for a tool tip or similar help text.
        ),
        (
          name = "tech",
          title = (defaultText = "tech"),
          description = (defaultText = "ability to see and handle tickets"),
        ),
        (
          name = "customer",
          title = (defaultText = "customer"),
          description = (defaultText = "ability to create tickets"),
        ),
      ],
      roles = [
        # Roles are logical collections of permissions.  For instance, your app may have
        # a "viewer" role and an "editor" role
        (
          title = (defaultText = "admin"),
          # Name of the role.  Shown in the Sandstorm UI to indicate which users have which roles.
  
          permissions  = [true,true,true],
          # An array indicating which permissions this role carries.
          # It should be the same length as the permissions array in
          # viewInfo, and the order of the lists must match.
  
          verbPhrase = (defaultText = "can do anything"),
          # Brief explanatory text to show in the sharing UI indicating
          # what a user assigned this role will be able to do with the grain.
  
          description = (defaultText = "admins can edit and configure all settings."),
          # Prose describing what this role means, suitable for a tool tip or similar help text.
        ),
		(
          title = (defaultText = "tech"),
          permissions  = [false,true,true],
          verbPhrase = (defaultText = "can see and handle tickets"),
          description = (defaultText = "techs can see and handle tickets."),
        ),
        (
          title = (defaultText = "customer"),
          permissions  = [false,false,true],
          verbPhrase = (defaultText = "can create tickets"),
          description = (defaultText = "customers can create tickets."),
        ),
      ],
    ),
    #apiPath = "/api/",
    # Apps can export an API to the world.  The API is to be used primarily by Javascript
    # code and native apps, so it can't serve out regular HTML to browsers.  If a request
    # comes in to your app's API, sandstorm-http-bridge will prefix the request's path with
    # this string, if specified.
  ),
);

const myCommand :Spk.Manifest.Command = (
  # Here we define the command used to start up your server.
  argv = ["/sandstorm-http-bridge", "8000", "--", "/bin/bash", "/opt/app/.sandstorm/launcher.sh"],
  environ = [
    # Note that this defines the *entire* environment seen by your app.
    (key = "PATH", value = "/usr/local/bin:/usr/bin:/bin"),
    (key = "SANDSTORM", value = "1"),
    # Export SANDSTORM=1 into the environment, so that apps running within Sandstorm
    # can detect if $SANDSTORM="1" at runtime, switching UI and/or backend to use
    # the app's Sandstorm-specific integration code.
  ]
);
