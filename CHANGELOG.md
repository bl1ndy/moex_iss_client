# Changelog

## [Unreleased]

## [0.2.0]

### Added

- `MoexIssClient::Client#history` - support for foreign stocks and DRs, ETFs, MFs, corporate bonds in RUB.
- `MoexIssClient::Security` - support for parsing any data sample (not only the last one) of sequrity history.

## [0.1.0] - 2023-03-19

### Added

- Class `MoexIssClient::Client` with method `#history` gets data from ISS for specified security and date interval. Currently only supports Russian stocks, DRs and government bonds in RUB.
- Class `MoexIssClient::HistoryValidator` with method `#validate` validates data of security history.
- Class `MoexIssClient::Security` describes security history and provides methods for parsing. Currently supports parsing only the latest data sample.
- Method `MoexIssClient::Security#attribute` gets value of specified attribute if it presents.
- Method `MoexIssClient::Security#last_price` is alias for `#attribute('CLOSE')`.
- Method `MoexIssClient::Security#shortname` is alias for `#attribute('SHORTNAME').`
- Method `MoexIssClient::Security#sec_id` is alias for `#attribute('SEC_ID')`.
