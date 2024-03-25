/** @type {import('tailwindcss').Config} */
module.exports = {
    content: {
        relative: true,
        files: ["*.html", "./src/**/*.rs"],
    },
    theme: {
        extend: {
            fontFamily: {
                sans: ["Cormorant Garamond"],
            }
        },
    },
    plugins: [],
}
    