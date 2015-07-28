function calculateScale(width, height) {
    // scale relative to hight and width
    var widthScale = (window.width - 50) / width
    var heightScale = (window.height - 50) / height

    return Math.min(widthScale, heightScale);
}
