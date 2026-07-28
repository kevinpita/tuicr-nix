{ lib
, rustPlatform
, fetchFromGitHub
, git
,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "tuicr";
  version = "0.19.1";

  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "agavra";
    repo = "tuicr";
    tag = "v${finalAttrs.version}";
    hash = "sha256-uLtwpieKBTbLLDmgE4LLNljvv69i0cBRvU1WEgy09Xo=";
  };

  cargoHash = "sha256-jEPgXXlqTgVX+GutQX8JCwtLS0J3cx7RV76NdM5m6QE=";

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
