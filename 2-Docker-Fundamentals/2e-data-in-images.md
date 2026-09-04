# 2e. Data in images

[← Back to index](../index.md)

## 1. Copying data

The Dockerfile `COPY` instruction copies files/directories from the build context (the folder passed to `docker image build`) into the image:

```
COPY app.js /usr/src/app/app.js
COPY package.json package-lock.json ./
```

## 2. Using wildcards

`COPY` supports glob-style wildcards to match multiple files at once:

```
COPY *.json ./
COPY src/*.js ./src/
```

## 3. The magic of ADD

`ADD` does everything `COPY` does, plus two extras: it can fetch a file from a remote URL, and it automatically extracts local tar archives into the destination. Because these behaviors can be surprising, `COPY` is generally preferred unless one of these features is specifically needed.

```
ADD https://example.com/file.tar.gz /tmp/
ADD archive.tar.gz /app/
```

## 4. Ignoring files

A `.dockerignore` file (placed next to the Dockerfile) lists paths to exclude from the build context, similar to `.gitignore`. This keeps images smaller/builds faster and avoids accidentally copying things like `node_modules`, `.git`, or local secrets into the image.

```
node_modules
.git
*.log
```
