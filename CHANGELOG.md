# Changelog

## Next version

- Add `Agilibox::Monkey`

## 1.3.4

- Support FontAwesome v4

## 1.3.3

- Fix error messages

## 1.3.2

- Add `Agilibox::ActiveModelCustomErrorMessages`

## 1.3.1

- `ApiControllerConcern` refactor + helpers

## 1.3.0

- ApiControllerConcern : add `model_errors` in json response
- `json_response` is now a `HashWithIndifferentAccess`

## 1.2.3

- Add FCM

## 1.2.2

- Add CollectionUpdate
- Rename Agilibox::SortableUUIDGenerator::generate to ::call

## 1.2.1

- Fix flash partial
- Filter by date/datetime period now allows custom periods
- Sorter class improvements

## 1.2.0

- Add `Agilibox::MiniFormObject`
- Replace time period filter by date+datetime period filters
- JS Modal improvements
- Change Cucumber config :
  - add Chrome Headless support
  - rename `phantomjs_window_size` to `window_size`
  - refactoring
  - you now need to add `Agilibox::CucumberConfig.require_poltergeist!` or `Agilibox::CucumberConfig.require_chrome_headless!` to your `env.rb`

## 1.1.0

- Search concern improvements
- Date helper improvements
- Add `boolean_icon` helper
- Add i18n attributes
- Add `Agilibox::PluckToHash`
- Switch to FontAwesome 5 + `icon` helper improvements

## 1.0.15

- `ApiControllerConcern#render_json_error` improvements
- Add Agilibox::Service object
- Fix SMS AmazonSNS strategy bug
- Fix time period filter

## 1.0.14

- Sorting helper improvements
- FormBackUrl fixes
- FiltersHelper fixes

## 1.0.13

- Modal JS fix

## 1.0.12

- `.checkboxes-dropdown` CSS fix
- Fix sorting helper

## 1.0.11

- Add Agilibox::SMS
- Test helpers improvements

## 1.0.10

- Add TokenGenerator
- Add PhoneNumberSanitizer
- Add engine_file helper to Kernel
- Syntax improvements and refactors
- Add H alias of Agilibox::AllHelpers
- Add TimestampHelpers
- Add MiniModelSerializer
- Add ApiControllerConcern

## 1.0.9

- Fix Model#tv
- Add cucumber helpers

## 1.0.8

- Serializers improvements

## 1.0.7

- Search form add reset button
- Filter form fix default submit button

## 1.0.6

- Add checkboxes_dropdown helper
- Add FilterStrategyByKeyValues
- bs_button improvements
- Add Filter#any? and Filter#empty?
- Add i18n actions
- Add ModelI18n#tv
- Split i18n files

## 1.0.5

- Fix `import_button` helper
- Add mime types

## 1.0.4

- Search now ignore accents
- Add Sorter class

## 1.0.3

- Add `ta` (translate action) helper
- Add `blank` css class to `info` helper
- Add autocomplete.coffee

## 1.0.2

- Button helper changes
- Modals use event delegation

## 1.0.1

- Remove AXLSX dependency

## 1.0.0

- First version imported from agilidee/dorsale
- `sortable_column_order` now returns symbols
- modal fixes + allow upload
