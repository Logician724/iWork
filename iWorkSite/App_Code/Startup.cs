using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(iWorkSite.Startup))]
namespace iWorkSite
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
