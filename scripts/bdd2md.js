const fs = require('fs');

function containsGherkin(line) {
    const regex = /^\s*(Feature|Rule|Background|Scenario|Scenario Outline|Given|And|When|Then|Examples|\||@)/g;
    return line.match(regex)
}

function ConvertGherkinLinesToMarkdown(lines) {
    return lines.map(function(line) {
        return containsGherkin(line)
            ? line
                .replace(/^\s*(Feature:)/, '# $1')
                .replace(/^\s*(Rule:)/, '## $1')
                .replace(/^\s*(Background:|Scenario:|Scenario Outline:)/, '### $1')
                .replace(/^\s*(Given|And|When|Then)/, '* __$1__')
                .replace(/^\s*(Examples:)/, '#### $1')
                .replaceAll(/(@\w*)/g, '`$1`')
                .replace(/\s*\|/, '|')
                .replace(/</, '\\<')
                .replace(/>/, '\\>')
            : line + '  '
            ;
    });
}

function containsDutchGherkin(line) {
    const regex = /^\s*(Functionaliteit|Rule|Achtergrond|Scenario|Abstract Scenario|Gegeven|En|Als|Dan|Voorbeelden|\||@)/g;
    return line.match(regex)
}

function ConvertDutchGherkinLinesToMarkdown(lines) {
    return lines.map(function(line) {
        return containsDutchGherkin(line)
            ? line
                .replace(/^\s*(Functionaliteit:)/, '# $1')
                .replace(/^\s*(Rule:)/, '## $1')
                .replace(/^\s*(Achtergrond:|Scenario:|Abstract Scenario:)/, '### $1')
                .replace(/^\s*(Gegeven|En|Als|Dan)/, '* __$1__')
                .replace(/^\s*Voorbeelden:/, '#### Voorbeelden:')
                .replaceAll(/(@[\w-]*)/g, '`$1`')
                .replace(/\s*\|/, '|')
                .replace(/</, '\\<')
                .replace(/>/, '\\>')
            : line + '  '
            ;
    });
}

function writeMarkdownLinesToFile(filePath, lines) {
    let file = fs.createWriteStream(filePath, 'utf-8');

    const featureLine = lines.find(line => line.startsWith('# Functionaliteit') || line.startsWith('# Feature'));
    const match = featureLine.match(/# (Feature|Functionaliteit): (.*)/);
    file.write('---\n');
    file.write('layout: page-with-side-nav\n');
    file.write(`title: ${match[2]}\n`);
    file.write('---\n');
    
    let dataTableStart = false;
    lines.forEach(line => {
        if(line.startsWith('|')) {
            if(!dataTableStart) {
                file.write('\n');
            }

            file.write('  ' + line);

            if(!dataTableStart) {
                const tableSeparator = line.replaceAll(/[\w\s\.\(\)]/g, '-');
                file.write('\n  ' + tableSeparator);
                dataTableStart = true;
            }
        }
        else {
            file.write(line.trimStart());
            dataTableStart = false;
        }
        file.write('\n');

        if(line.startsWith('#')) {
            file.write('\n');
        }
    });
    file.end();
}

function getFeatureFiles(src) {
    let files = [];

    const items = fs.readdirSync(src, {withFileTypes: true});
    for(const item of items) {
        if(item.isDirectory() && item.name !== 'dev') {
            files = [...files, ...getFeatureFiles(`${src}/${item.name}`)];
        }
        else if(item.name.match(/.*\.feature/)) {
            files.push(`${src}/${item.name}`);
        }
    }

    return files;
}

function convertFeatureFileToMarkdownLines(file) {
    const lines = fs.readFileSync(file, { encoding: 'utf8' }).split(/\r?\n/);

    return lines[0].match(/#\s*language:\s*nl/) 
        ? ConvertDutchGherkinLinesToMarkdown(lines)
        : ConvertGherkinLinesToMarkdown(lines);
}

function createParentDirectory(file) {
    const dir = file.substring(0, file.lastIndexOf('/'));

    fs.mkdirSync(dir, { recursive: true });
}

function bdd2md(source, target) {
    const featureFiles = getFeatureFiles(source);
    featureFiles.forEach(file => {
        const lines = convertFeatureFileToMarkdownLines(file);

        const targetFile = `${file.replace(source, target)}.md`;
        createParentDirectory(targetFile);

        writeMarkdownLinesToFile(targetFile, lines);
    });
}

bdd2md('./features/raadpleeg-bewoning-op-peildatum/gba', './docs/v2/features/raadpleeg-bewoning-op-peildatum/gba');
