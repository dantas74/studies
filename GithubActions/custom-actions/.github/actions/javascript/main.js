const core = require('@actions/core');
const github = require('@actions/github');
const exec = require('@actions/exec');

function run() {
    const bucketName = core.getInput('bucket', {required: true});
    const bucketRegion = core.getInput('bucket-region', {required: false});
    const distFolder = core.getInput('dist-folder', {required: true});

    const s3URI = `s3://${bucketName}`;

    exec.exec(`aws s3 sync ${distFolder} ${s3URI} --region ${bucketRegion}`);

    const websiteUrl = `https://${bucketName}.s3-website-${bucketRegion}.amazonaws.com`;

    core.setOutput('website-url', websiteUrl);
}

run();
