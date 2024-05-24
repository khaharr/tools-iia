import 'bootstrap-table'
import 'bootstrap-table/dist/locale/bootstrap-table-fr-FR.min.js'
import 'bootstrap-table/dist/extensions/export/bootstrap-table-export'
import type { BootstrapTableOptions } from 'bootstrap-table';
declare global {
    interface JQuery {
        bootstrapTable(options: BootstrapTableOptions): JQuery;

        bootstrapTable(method: string, ...parameters: any[]): JQuery | any;
    }
}

export default defineNuxtPlugin({})
