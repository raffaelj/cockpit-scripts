<div>
    <ul class="uk-breadcrumb">
        <li class="uk-active"><span>Migrate</span></li>
    </ul>
</div>


<div riot-view>

    <div class="uk-container uk-container-center">

        <a href="@route('/migrate/migrate')" target="_blank">@lang('Migrate (dry-run)')</a>
        
<!--        <div class="">
        
            <h2>@lang('Roles')</h2>
            
            <div each="{ roleGroup, status in roles }" if="{ roleGroup.length }">
            { status }
            <ul if="{ roleGroup.length }">
                <li each="{ role in roleGroup }">{ role.appid }</li>
            </ul>
            </div>
        
        </div>-->

        <button type="button" class="uk-button uk-button-primary" onclick="{ migrate }">
            @lang('Migrate')
        </button>

        <button type="button" class="uk-button uk-button-danger" onclick="{ deleteV1stuff }">
            <i class="uk-icon uk-icon-warning"></i>
            @lang('delete v1 stuff')
        </button>

        <button type="button" class="uk-button uk-button-danger" onclick="{ deleteV2stuff }">
            @lang('delete v2 stuff')
        </button>



    </div>

<!--     <cp-inspectobject ref="inspect"></cp-inspectobject> -->

    <script type="view/script">

        var $this = this;

        // this.mixin(RiotBindMixin);

        this.version = '{{ $version }}';

        // this.messages      = [];
        // this.roles         = [];
        // this.accounts      = [];
        // this.locales       = [];
        // this.assetsFolders = [];
        // this.assets        = [];
        // this.models        = [];


        this.on('mount', function() {

//             App.request('/migrate/overview').then(data => {
// 
//                 this.messages      = data.messages;
//                 this.roles         = data.roles;
//                 this.accounts      = data.accounts;
//                 this.locales       = data.locales;
//                 this.assetsFolders = data.assetsFolders;
//                 this.assets        = data.assets;
//                 this.models        = data.models;
//                 
//                 this.update();
// 
//             });

        });

        this.migrate = function() {
            App.ui.confirm('Start migration?', () => {
                App.request('/migrate/migrate/all/write').then(data => {
                    App.ui.notify('Migrated data');
                });
            });
        }

        this.deleteV1stuff = function() {
            App.ui.confirm('Delete v1 related models and databases?', () => {
                App.request('/migrate/deleteV1stuff').then(data => {
                    App.ui.notify('Deleted v1 stuff');
                });
            });
        }

        this.deleteV2stuff = function() {
            App.ui.confirm('Delete v2 related models and databases?', () => {
                App.request('/migrate/deleteV2stuff').then(data => {
                    App.ui.notify('Deleted v2 stuff');
                });
            });
        }

    </script>

</div>
