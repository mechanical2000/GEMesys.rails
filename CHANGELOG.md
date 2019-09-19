# Changelog

## Next version
- Cuprite : improve config + increase timeout

## 1.7.0
- ActiveRecord/ActiveModel type cast : refactor + add date + add boolean

## 1.6.2
- Fix cucumber/capybara helpers

## 1.6.1
- Add `SetupJobConcern`

## 1.6.0
- Remove `GetHTTP`
- I18n fixes
- Add `Agilibox::TapMethods`
- Filters CSS : add flex-wrap
- Add `bs_card` helper
- Add `:br` separator to `info` helper
- TextHelper refactors
- Update dummy app to Rails 5.2
- Replace AXLSX by SpreadsheetArchitect

## 1.5.13
- Fix `info` helper with nested blank value

## 1.5.12
- Cuprite config improvements

## 1.5.11
- Add `nbsp` helper
- Add `PluckDistinct` model concern
- Add pagination helpers

## 1.5.10
- Cucumber Helpers : add cuprite support

## 1.5.9
- I18n fix
- Add `bs_progress_bar` helper

## 1.5.8
- Add GetHTTP#response

## 1.5.7
- `download_button` and `export_button` fixes
- checkboxes-dropdown CSS improvements
- Change searchbar CSS

## 1.5.6
- Various fixes on filters

## 1.5.5
- Add ModelI18n::raise_on_missing_translations option

## 1.5.4
- Cucumber "click on" steps improvement

## 1.5.3
- Fix FontAwesome >=5.6

## 1.5.2
- GetHTTP service improvements
- New common steps + improvements

## 1.5.1
- Add CSS helpers
- Add Cucumber common steps
- Add Cucumber select2 helper

## 1.5.0
- Add `GetHTTP`
- Add BS4 search form

## 1.4.4
- Fix i18n error on `info` helper

## 1.4.3
- `form_buttons` helper fixes and improvements

## 1.4.2
- Fix FontAwesome helper

## 1.4.1
- FCM request handle JSON errors

## 1.4.0
- Add `Agilibox::Email`
- Add `Agilibox.parent_controller` config
- Add `Agilibox.parent_mailer` config
- Filters improvements

## 1.3.6
- Remove deprecated `Agilibox::SortableUUIDGenerator::generate`
- `Agilibox::ActiveRecordUUIDConcern` improvements
- `Agilibox::DefaultValuesConcern` improvements
- Fix FontAwesome version error

## 1.3.5
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
