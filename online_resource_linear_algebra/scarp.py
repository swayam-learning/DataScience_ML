import os
import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin, urlparse

# URL of the webpage to download
url = "https://pabloinsente.github.io/intro-linear-algebra"

# Send a GET request to the webpage
response = requests.get(url)

# Check if the request was successful
if response.status_code == 200:
    # Create a directory to save the webpage and resources
    base_dir = "downloaded_page"
    if not os.path.exists(base_dir):
        os.makedirs(base_dir)
    img_dir = os.path.join(base_dir, "images")
    if not os.path.exists(img_dir):
        os.makedirs(img_dir)
    css_dir = os.path.join(base_dir, "css")
    if not os.path.exists(css_dir):
        os.makedirs(css_dir)

    # Parse the HTML content of the page
    soup = BeautifulSoup(response.content, 'html.parser')

    # Function to download and save an image
    def download_image(img_url):
        if not img_url:
            return None

        # Handle relative URLs
        img_url = urljoin(url, img_url)
        img_name = os.path.basename(urlparse(img_url).path)
        img_path = os.path.join(img_dir, img_name)

        try:
            img_data = requests.get(img_url).content
            with open(img_path, "wb") as img_file:
                img_file.write(img_data)
            return f"images/{img_name}"
        except requests.exceptions.RequestException as e:
            print(f"Failed to download image {img_url}: {e}")
            return None

    # Find and download all image tags
    img_tags = soup.find_all("img")
    for img in img_tags:
        img_url = img.get("src")
        local_img_path = download_image(img_url)
        if local_img_path:
            img['src'] = local_img_path

    # Find and download background images from CSS
    css_tags = soup.find_all("link", rel="stylesheet")
    for css in css_tags:
        css_url = css.get("href")
        if not css_url:
            continue
        css_url = urljoin(url, css_url)
        css_name = os.path.basename(urlparse(css_url).path)
        css_path = os.path.join(css_dir, css_name)

        try:
            css_data = requests.get(css_url).text
            with open(css_path, "w", encoding="utf-8") as css_file:
                css_file.write(css_data)
            
            # Update CSS file to point to local images
            with open(css_path, "r+", encoding="utf-8") as css_file:
                css_content = css_file.read()
                for bg_img_url in soup.find_all(style=True):
                    bg_img_url = bg_img_url['style'].split('url(')[-1].split(')')[0].strip('\'"')
                    local_bg_img_path = download_image(bg_img_url)
                    if local_bg_img_path:
                        css_content = css_content.replace(bg_img_url, local_bg_img_path)
                css_file.seek(0)
                css_file.write(css_content)
                css_file.truncate()

            css['href'] = f"css/{css_name}"
        except requests.exceptions.RequestException as e:
            print(f"Failed to download CSS {css_url}: {e}")

    # Save the modified HTML content to a local file
    with open(os.path.join(base_dir, "index.html"), "w", encoding="utf-8") as file:
        file.write(str(soup))

    print("Webpage and resources downloaded and saved in the 'downloaded_page' directory.")
else:
    print(f"Failed to retrieve the webpage. Status code: {response.status_code}")
