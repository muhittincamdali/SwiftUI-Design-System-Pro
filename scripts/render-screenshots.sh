#!/usr/bin/env bash
# Renders the component gallery (Tests/DesignSystemProTests/ComponentGallery.swift)
# to PNG files in docs/images using SwiftUI's ImageRenderer on macOS.
#
# Usage: scripts/render-screenshots.sh [output-directory]
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
output_dir="${1:-$repo_root/docs/images}"

cd "$repo_root"
DSP_SCREENSHOT_DIR="$output_dir" swift test --filter "RenderingTests/exportScreenshots"

echo "Screenshots written to $output_dir"
