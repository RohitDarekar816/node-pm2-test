module.exports = {
  apps: [
    {
      name: "hello-world-app",
      script: "app.js",
      instances: 4, // Reduced from 10 - adjust based on your CPU cores
      exec_mode: "cluster",
      watch: false, // Disabled for production, enable for development
      max_memory_restart: "1G",
      env: {
        NODE_ENV: "development",
        PORT: 3000
      },
      env_production: {
        NODE_ENV: "production",
        PORT: 8080
      },
      // Logging configuration
      log_file: "./logs/app.log",
      out_file: "./logs/out.log",
      error_file: "./logs/error.log",
      log_date_format: "YYYY-MM-DD HH:mm:ss Z",
      
      // Auto restart configuration
      autorestart: true,
      max_restarts: 10,
      min_uptime: "10s",
      
      // For ES modules support
      node_args: "--experimental-modules"
    }
    // Note: Removed service-worker app since the directory doesn't exist
    // Add it back when you create the service-worker directory and files
  ],

  deploy: {
    production: {
      user: "root", // Consider creating a dedicated user instead
      key: "/home/rohitdarekar/learn/sshkey",
      host: "143.244.131.199",
      ref: "origin/main",
      repo: "https://github.com/RohitDarekar816/node-pm2-test.git",
      path: "/root/rohit",
      "post-deploy": "bash ~/rohit/source/deploy-fixed.sh",
      env: {
        NODE_ENV: "production"
      }
    }
  }
};