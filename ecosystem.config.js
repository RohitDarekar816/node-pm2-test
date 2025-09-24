module.exports = {
  apps: [
    {
      script: "app.js",
      watch: ".",
      instances: "10",
    },
    {
      script: "./service-worker/",
      watch: ["./service-worker"],
    },
  ],

  deploy: {
    production: {
      user: "root",
      key: "/home/rohitdarekar/learn/node/sshkey",
      host: "142.93.219.250",
      ref: "origin/main",
      repo: "https://github.com/RohitDarekar816/node-pm2-test.git",
      path: "/root",
      "post-deploy": "npm install",
    },
  },
};
