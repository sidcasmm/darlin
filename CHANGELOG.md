
## [1.0.2] - 2025-08-04

### Major Features
- **Modular Imports**: Added modular import functionality allowing users to import only specific subsets of functionality
  - Individual module files: `string_utils.dart`, `scope_functions.dart`, `list_utils.dart`, `nullable_utils.dart`, `boolean_utils.dart`, `future_utils.dart`, `object_utils.dart`
  - Convenience modules: `core.dart` (most common utilities), `collections.dart` (list + object utilities)
  - Benefits include smaller bundle size, better tree-shaking, clearer dependencies, and faster compilation

- **Future Extensions**: Enhanced future handling with utility extensions
  - Added `future_utils.dart` module with future-specific utilities
  - Improved async/await workflow support

- **Object Extensions**: Enhanced object manipulation capabilities
  - Added `object_utils.dart` module with object-specific utilities
  - Improved object handling and manipulation features

### Documentation & Examples
- Updated documentation with modular import examples and benefits
- Added `modular_imports_example.dart` demonstrating all import options
- Added `future_utilities_example.dart` showcasing future utilities
- Added `kotlin_like_utils_example.dart` demonstrating object and other utilities

## [1.0.1] - 2025-08-04
- Updated README.md with proper usage examples and improved formatting.

## 1.0.0

### Features
- **String Extensions**: Null safety checks (`isNullOrEmpty`, `isNullOrBlank`, `isNotNullOrEmpty`, `isNotNullOrBlank`) and utilities (`reversed`, `capitalize()`, `isNumeric`, `isEmail`, `removeWhitespaces()`, `limit()`)
- **List Extensions**: Null safety checks (`isNullOrEmpty`, `isNotNullOrEmpty`) and utilities (`firstOrNull()`, `lastOrNull()`, `singleOrNull()`, `distinctBy()`, `takeIf()`, `takeUnless()`, `filterNotNull()`, `mapNotNull()`)
- **Nullable Extensions**: General null safety utilities (`isNull`, `isNotNull`, `ifNull()`, `ifNotNull()`) for any type
- **Boolean Extensions**: Toggle functionality (`toggle()`) and logical operations (`xor()`, `and()`, `or()`) for nullable booleans
- **Scope Functions**: Kotlin-like scope functions (`let`, `also`, `apply`) for any object type

### Documentation
- Comprehensive API documentation with examples
- Complete test coverage (150+ tests)
- Working examples demonstrating all features
- README with usage examples and API reference

### Technical Details
- Null-safe and idiomatic Dart code
- Full type safety with generics support
- Lightweight with minimal dependencies
- Cross-platform support (Android, iOS, Linux, macOS, Web, Windows)
