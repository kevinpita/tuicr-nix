{ lib
, rustPlatform
, fetchFromGitHub
, git
,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "tuicr";
  version = "0.23.1";

  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "agavra";
    repo = "tuicr";
    tag = "v${finalAttrs.version}";
    hash = "sha256-SvRvoQN9b4pXg4rPFnYI2Yeg3SAZKyjYknR2AzfoHnY=";
  };

  cargoHash = "sha256-1h8jDRssVA7gNfHB/9Uh1QWOsNF+aUBU698P/qLbyeY=";

  strictDeps = true;

  nativeCheckInputs = [ git ];

  checkFlags = [
    # This test expects to run from the original upstream Git repository.
    "--skip=should_return_no_changes_for_clean_repo"
  ];

  meta = {
    description = "Review AI-generated diffs like a GitHub pull request from your terminal";
    homepage = "https://tuicr.dev";
    changelog = "https://github.com/agavra/tuicr/blob/v${finalAttrs.version}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ kevinpita ];
    mainProgram = "tuicr";
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ];
  };
})
