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
      key: "/home/rohitdarekar/learn/sshkey",
      host: "143.244.131.199",
      ref: "origin/main",
      repo: "https://github.com/RohitDarekar816/node-pm2-test.git",
      path: "/root/rohit",
      "post-deploy": "npm install",
    },
  },
};
