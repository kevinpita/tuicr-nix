{ lib
, rustPlatform
, fetchFromGitHub
, git
,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "tuicr";
  version = "0.21.0";

  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "agavra";
    repo = "tuicr";
    tag = "v${finalAttrs.version}";
    hash = "sha256-9QEDfDwb9Elm4R40/0pBz0EgTOoJJWWNraz2D0H6bAo=";
  };

  cargoHash = "sha256-efBYiq0FA9kpMwzHM2GiUC2rWyWC9QcgfCCVIu5bbPk=";

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
