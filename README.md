# Rails i18n GitHub Action example

This repo shows how to translate a Rails app's i18n YAML files automatically on every pull request with a GitHub Action. When a pull request adds or changes keys in `config/locales/en.yml`, the [Localhero.ai](https://localhero.ai) action translates them into Swedish, Polish and German and commits the updated YAML files to the same pull request.

## How it works

The app is a single team settings page built with Rails 8, with its strings in `config/locales/`. The workflow in `.github/workflows/localhero-translate.yml` runs `localheroai/localhero-action@v1` on pull requests that touch `config/locales/**` or `localhero.json`. The action compares the branch with the base branch and translates only the keys that are new, changed or missing. It writes them to `sv.yml`, `pl.yml` and `de.yml` using each language's own plural forms. Polish gets `one`, `few`, `many` and `other` even though English only has `one` and `other`. Nothing in the Rails code knows about Localhero.ai: views call `t(".title")` and read the YAML like any other Rails app.

## Setup in your own Rails app

1. In your app's root, run `npx @localheroai/cli init`. It finds `config/locales/`, asks for your source and target languages, writes `localhero.json` and offers to create the workflow file.
2. Get an API key at [localhero.ai/api-keys](https://localhero.ai/api-keys) and add it as the repository secret `LOCALHERO_API_KEY` (Settings → Secrets and variables → Actions).
3. Install the [Localhero.ai GitHub App](https://localhero.ai/docs/github-app) on the repository. The translation commit is then pushed by the App and your other workflows run on it. Without the App, GitHub doesn't start them on that commit automatically.
4. Open a pull request that adds a key to `config/locales/en.yml`.

To try it on a copy of this repo, delete `localhero.json` before running `init`. The one here belongs to this repo's own Localhero.ai project.

## What a translation pull request looks like

Say a pull request adds one key to the English file:

```yaml
en:
  team_settings:
    show:
      transfer_ownership: "Transfer ownership to %{name}"
```

The action adds a commit titled `Update translations` to the same branch. It adds the new key to `sv.yml`, `pl.yml` and `de.yml`. The commit message lists the number of keys, the languages and a link to the translations on Localhero.ai. The action also comments on the pull request with a link to review them. If a reviewer edits a translation on Localhero.ai, the edit comes back as a `Sync translations` commit on the same branch.

The code, the English strings and the translations are reviewed and merged together. The [closed pull requests](https://github.com/localheroai/rails-i18n-github-action-example/pulls?q=is%3Apr+is%3Aclosed) in this repo show a real one.

## Missing translation check

`.github/workflows/ci.yml` runs two jobs:

- `bin/rails test` renders the page in every locale with `config.i18n.raise_on_missing_translations` turned on. A missing key fails the test.
- `npx @localheroai/cli check --fail-on any` compares every locale file with the English one. It also catches what the test can't see: a Polish plural without its `few` form (Rails falls back to `other` and renders the wrong grammar), an empty value and a translation that dropped a `%{name}` placeholder. It runs offline with no account or API key.

On a pull request that adds an English key, `check` fails until the translation commit lands. The branch isn't ready to merge before every language has the new string.

## Run it locally

You need the Ruby version in `.ruby-version` and Node 20 or later for `check`.

```sh
bundle install
bin/rails server
bin/rails test
npx @localheroai/cli check
```

The page is at http://localhost:3000, with `/sv`, `/pl` and `/de` for the other languages.

## More

- [Translating Rails apps with Localhero.ai](https://localhero.ai/docs/rails)
- [GitHub Action inputs and options](https://localhero.ai/docs/github-actions)
- [The `check` command](https://localhero.ai/docs/check)

## License

MIT
