# Biome Configuration for Automatic Import Organization

This guide explains how to configure Biome to automatically organize imports in your TypeScript/JavaScript projects.

## Setup

1. **Create a `biome.json` file** in the root of your project
2. **Add the following configuration** to enable automatic import organization:

```json
{
  "$schema": "https://biomejs.dev/schemas/1.9.4/schema.json",
  "assist": {
    "enabled": true,
    "actions": {
      "source": {
        "organizeImports": "on"
      }
    }
  },
  "formatter": {
    "enabled": true,
    "formatWithErrors": false
  },
  "linter": {
    "enabled": true,
    "rules": {
      "recommended": true
    }
  }
}
```

## How It Works

With this configuration:
- **On file save**: Imports will be automatically organized
- **On manual format**: Imports will be organized when you trigger formatting
- **No warnings**: Biome won't show warnings for unorganized imports

## Additional Formatting Options

You can customize the formatter behavior:

```json
{
  "formatter": {
    "enabled": true,
    "formatWithErrors": false,
    "indentStyle": "space",
    "indentWidth": 2,
    "lineWidth": 100
  },
  "javascript": {
    "formatter": {
      "quoteStyle": "single",
      "semicolons": "asNeeded",
      "trailingCommas": "es5"
    }
  },
  "typescript": {
    "formatter": {
      "quoteStyle": "single",
      "semicolons": "asNeeded",
      "trailingCommas": "es5"
    }
  }
}
```

## Linter Rules

Add specific linter rules as needed:

```json
{
  "linter": {
    "enabled": true,
    "rules": {
      "recommended": true,
      "style": {
        "useImportType": "error"
      },
      "suspicious": {
        "noExplicitAny": "warn"
      }
    }
  }
}
```

## Team Collaboration

- Commit the `biome.json` file to your repository
- All team members will have the same import organization behavior
- Ensure Biome is installed in your project: `npm install --save-dev biome`

## Verification

To test if it's working:
1. Create a file with disorganized imports
2. Save the file
3. Imports should be automatically sorted and grouped

## Troubleshooting

If imports aren't organizing:
1. Ensure `biome.json` is in the project root
2. Check that `"organizeImports": "on"` is set in the assist configuration
3. Verify Biome is installed and running
4. Check for syntax errors that might prevent formatting