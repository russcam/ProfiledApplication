using System;
using System.Collections.Generic;
using System.Data.SQLite;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using Funq;
using ServiceStack;
using ServiceStack.Mvc;

namespace ProfiledApplication
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            new AppHost().Init();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }
    }
    
    public class AppHost : AppHostBase
    {
        /// <summary>
        /// Base constructor requires a Name and Assembly where web service implementation is located
        /// </summary>
        public AppHost()
            : base("ProfiledApplication", typeof(MyServices).Assembly) { }

        /// <summary>
        /// Application specific configuration
        /// This method should initialize any IoC resources utilized by your web service classes.
        /// </summary>
        public override void Configure(Container container)
        {
            SetConfig(new HostConfig());
            
            // create an in-memory db that lives as long as the connection is open
            var connection = new SQLiteConnection("data source=:memory:");
            connection.Open();

            container.Register(connection);

            ControllerBuilder.Current.SetControllerFactory(new FunqControllerFactory(container));
        }
    }
    
    public class MyServices : Service
    {
        private readonly SQLiteConnection _connection;

        public MyServices(SQLiteConnection connection) => _connection = connection;

        public object Any(Hello request)
        {
            using (var command = _connection.CreateCommand())
            {
                command.CommandText = "select sqlite_version();";
                using (var reader = command.ExecuteReader())
                {
                    // creates a span
                }
            }

            return new HelloResponse { Result = $"Hello, {request.Name}!" };
        }
    }
    
    [ServiceStack.Route("/hello")]
    [ServiceStack.Route("/hello/{Name}")]
    public class Hello : IReturn<HelloResponse>
    {
        public string Name { get; set; }
    }

    public class HelloResponse
    {
        public string Result { get; set; }
    }
}
