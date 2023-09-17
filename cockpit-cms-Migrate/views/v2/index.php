<vue-view>

    <template>

        <kiss-container class="kiss-margin-large">

            <ul class="kiss-breadcrumbs">
                <li><a href="<?=$this->route('/migrate')?>"><?=t('Migrate')?></a></li>
            </ul>

            <a href="<?=$this->route('/migrate/migrate')?>" target="_blank"><?=t('Migrate (dry-run)')?></a>

        </kiss-container>

        <app-actionbar>

        </app-actionbar>

    </template>

    <script type="module">

        export default {
        }
    </script>
</vue-view>



<?php //$this->start('app-side-panel') ?>



<?php //$this->end('app-side-panel') ?>
